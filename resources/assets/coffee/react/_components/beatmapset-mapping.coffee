# Copyright (c) ppy Pty Ltd <contact@ppy.sh>. Licensed under the GNU Affero General Public License v3.0.
# See the LICENCE file in the repository root for full licence text.

import * as React from 'react'
import { a, div, span, strong, time } from 'react-dom-factories'
import StringWithComponent from 'string-with-component'
import TimeWithTooltip from 'time-with-tooltip'
el = React.createElement

bn = 'beatmapset-mapping'
dateFormat = 'LL'

export class BeatmapsetMapping extends React.PureComponent
  render: =>
    user =
      id: @props.beatmapset.user_id
      username: @props.beatmapset.creator
      avatar_url: (@props.user ? @props.beatmapset.user)?.avatar_url

    div className: bn,
      if user.id?
        a
          href: laroute.route 'users.show', user: user.id
          className: 'avatar avatar--beatmapset'
          style:
            backgroundImage: osu.urlPresence(user.avatar_url)
      else
        span className: 'avatar avatar--beatmapset avatar--guest'

      div className: "#{bn}__content",
        div
          className: "#{bn}__mapper"
          dangerouslySetInnerHTML:
            __html: osu.trans 'beatmapsets.show.details.mapped_by',
              mapper: @userLink(user)

        @renderDate 'submitted', 'submitted_date'

        if @props.beatmapset.ranked > 0
          @renderDate @props.beatmapset.status, 'ranked_date'
        else
          @renderDate 'updated', 'last_updated'


  renderDate: (key, attribute) =>
    div null,
      el StringWithComponent,
        pattern: osu.trans "beatmapsets.show.details_date.#{key}"
        mappings:
          timeago:
            strong null,
              el TimeWithTooltip,
                dateTime: @props.beatmapset[attribute]
                relative: Math.abs(moment().diff(moment(@props.beatmapset[attribute]), 'weeks')) < 4


  userLink: (user) ->
    if user.id?
      laroute.link_to_route 'users.show',
        user.username
        { user: user.id }
        class: "#{bn}__user js-usercard"
        'data-user-id': user.id
    else
      "<span class='#{bn}__user'>#{_.escape(user.username ? osu.trans('users.deleted'))}</span>"
