React = require 'react/addons'
functions = require '../functions.coffee'
GameStateMixin = require '../mixins/game_state_mixin.cjsx'
CopyGameStateMixin = require '../mixins/copy_game_state_mixin.cjsx'
TeamSelector = require './shared/team_selector.cjsx'
TeamPenalties = require './penalty_tracker/team_penalties.cjsx'
cx = React.addons.classSet
module.exports = React.createClass
  displayName: 'PenaltyTracker'
  mixins: [GameStateMixin, CopyGameStateMixin]
  componentWillMount: () ->
    @actions =
      setPenalty: (teamType, skaterIndex, penaltyIndex) ->
        skater = @getSkaterState(teamType, skaterIndex)
        penalty = @getPenalty(penaltyIndex)
        lastPenaltyState = skater.penalties[-1..][0]
        sort = if lastPenaltyState? then lastPenaltyState.sort + 1 else 0
        skater.penalties.push
          penalty: penalty
          jamNumber: @state.gameState.jamNumber
          sort: sort
        exports.dispatcher.trigger 'penalty_tracker.set_penalty', @buildOptions(teamType: teamType, skaterIndex: skaterIndex)
        @setState(@state)
      clearPenalty: (teamType, skaterIndex, skaterPenaltiesIndex) ->
        skater = @getSkaterState(teamType, skaterIndex)
        removedPenalty = skater.penalties.splice(skaterPenaltiesIndex, 1)[0]
        exports.dispatcher.trigger 'penalty_tracker.clear_penalty', @buildOptions(teamType: teamType, skaterIndex: skaterIndex, removedPenalty: removedPenalty)
        @setState(@state)
      updatePenalty: (teamType, skaterIndex, skaterPenaltiesIndex, opts={}) ->
        skaterPenalty = @getPenaltyState(teamType, skaterIndex, skaterPenaltiesIndex)
        $.extend(skaterPenalty, opts)
        exports.dispatcher.trigger 'penalty_tracker.update_penalty', @buildOptions(teamType: teamType, skaterIndex: skaterIndex, skaterPenaltiesIndex: skaterPenaltiesIndex)
        @setState(@state)
  bindActions: (teamType) ->
    Object.keys(@actions).map((key) ->
      key: key
      value: @actions[key].bind(this, teamType)
    , this).reduce((actions, action) ->
      actions[action.key] = action.value
      actions
    , {})
  buildOptions: (opts= {} ) ->
    stdOpts =
      role: 'Penalty Tracker'
      timestamp: Date.now
      state: @state.gameState
    $.extend(stdOpts, opts)
  getInitialState: () ->
    componentId: functions.uniqueId()
  render: () ->
    awayElement = <TeamPenalties team={@state.gameState.away} penalties={@state.gameState.penalties} actions={@bindActions('away') }/>
    homeElement = <TeamPenalties team={@state.gameState.home} penalties={@state.gameState.penalties} actions={@bindActions('home') }/>
    <div className="penalty-tracker">
      <TeamSelector
        away={@state.gameState.away}
        awayElement={awayElement}
        home={@state.gameState.home}
        homeElement={homeElement} />
   	</div>
