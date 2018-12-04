###
#    Copyright 2015-2018 ppy Pty. Ltd.
#
#    This file is part of osu!web. osu!web is distributed with the hope of
#    attracting more community contributions to the core ecosystem of osu!.
#
#    osu!web is free software: you can redistribute it and/or modify
#    it under the terms of the Affero GNU General Public License version 3
#    as published by the Free Software Foundation.
#
#    osu!web is distributed WITHOUT ANY WARRANTY; without even the implied
#    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with osu!web.  If not, see <http://www.gnu.org/licenses/>.
###

{div} = ReactDOMFactories
el = React.createElement
bn = 'profile-detail'

class ProfilePage.Detail extends React.PureComponent
  constructor: (props) ->
    super props

    @state = extended: true


  render: =>
    div className: bn,
      div className: "#{bn}__bar",
        el ProfilePage.DetailBar,
          stats: @props.stats
          toggleExtend: @toggleExtend
          extended: @state.extended
          user: @props.user
      div
        className: if @state.extended then '' else 'hidden'
        div className: "#{bn}__row #{bn}__row--top",
          div className: "#{bn}__col #{bn}__col--top-left",
            div className: "#{bn}__top-left-item",
              el ProfilePage.PlayTime, stats: @props.stats
            div className: "#{bn}__top-left-item",
              el ProfilePage.MedalsCount, userAchievements: @props.userAchievements
            div className: "#{bn}__top-left-item",
              el ProfilePage.Pp, stats: @props.stats

          div className: "#{bn}__col",
            el ProfilePage.RankCount, stats: @props.stats
        div className: "#{bn}__row",
          div className: "#{bn}__col #{bn}__col--bottom-left",
            if @props.rankHistory?
              el ProfilePage.RankChart,
                rankHistory: @props.rankHistory
                stats: @props.stats
            else
              div className: "#{bn}__empty-chart",
                osu.trans('users.show.extra.unranked')

          div className: "#{bn}__col #{bn}__col--bottom-right",
            div className: "#{bn}__bottom-right-item",
              div className: 'value-display value-display--large',
                div className: 'value-display__label',
                  osu.trans('users.show.rank.global_simple')
                div className: 'value-display__value',
                  if @props.stats.rank.global?
                    @props.stats.rank.global.toLocaleString()
                  else
                    '-'

            div className: "#{bn}__bottom-right-item",
              div className: 'value-display',
                div className: 'value-display__label',
                  osu.trans('users.show.rank.country_simple')
                div className: 'value-display__value',
                  if @props.stats.rank.country?
                    @props.stats.rank.country.toLocaleString()
                  else
                    '-'


  toggleExtend: =>
    @setState extended: !@state.extended
