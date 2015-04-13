React = require 'react/addons'
cx = React.addons.classSet
module.exports = React.createClass
  displayName: 'PenaltiesList'

  render: () ->
    containerClass = cx
      'penalties-list': true
      'hidden': @props.hidden
    <div className={containerClass}>
      {@props.penalties[0...-1].map((penalty, penaltyIndex) ->
        <div key={penaltyIndex} className='penalty'>
          <div className='col-xs-1 col-sm-1'>
            <button className='penalty-code bt-btn btn-boxed' onClick={@props.buttonHandler.bind(null, penaltyIndex)}>
              <strong>{penalty.code}</strong>
            </button>
          </div>
          <div className='col-xs-5 col-sm-5'>
            <button className='penalty-name bt-btn btn-boxed' onClick={@props.buttonHandler.bind(null, penaltyIndex)}>
              <strong>{penalty.name}</strong>
            </button>
          </div>
        </div>
      , this).map((elem, i, elems) ->
        if i % 2 then null else <div key={i} className='row gutters-xs top-buffer'>{elems[i..i+1]}</div>
      ).filter (elem) ->
        elem?
      }
      <div className='row gutters-xs top-buffer'>
        <div className='col-xs-1 col-sm-1'>
          <button className='penalty-code bt-btn btn-boxed' onClick={@props.buttonHandler.bind(null, @props.penalties.length - 1)}>
            <strong>{@props.penalties[@props.penalties.length - 1].code}</strong>
          </button>
        </div>
        <div className='col-xs-11 col-sm-11'>
          <button className='penalty-name bt-btn btn-boxed' onClick={@props.buttonHandler.bind(null, @props.penalties.length - 1)}>
            <strong>{@props.penalties[@props.penalties.length - 1].name} - Expulsion</strong>
          </button>
        </div>
      </div>
    </div>