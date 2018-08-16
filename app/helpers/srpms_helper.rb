# frozen_string_literal: true

module SrpmsHelper
  def colorize_specfile(text)
    text.force_encoding('UTF-8')
    text = text.gsub('@altlinux', ' at altlinux')

    # ${$text}=~ s/&/&amp;/g;
    # ${$text}=~ s/>/&gt;/g;
    # ${$text}=~ s/</&lt;/g;
    # ${$text}=~ s/\"/&quot;/g;
    text = ERB::Util.h(text)

    # ${$text}=~ s/\@/ at /g;

    # ${$text}=~ s/(Url\:\s+)(((http|ftp)\:\/\/[^\s\[\]]{1,100})([^\s\]\[]*))/"$1".&linkme($2,$3,$5)/gie;
    # TODO: add link to Url:

    # ${$text}=~ s/^(\w+\:)/<b>$1<\/b>/g;
    text = text.gsub(/^(\w+\:)/) { |s| s = "<b>#{ s }</b>" }

    text = text.gsub(/\t/, '&nbsp;' * 8)
    text = text.gsub(' ', '&nbsp;')

    # ${$text}=~ s/^(\s*\#.*)/<b class='comment'>$1<\/b>/g;
    # text = text.gsub(/^(\s*\#.*)/) { |s| s = "<b class='comment'>#{s}</b>" }

    # ${$text}=~ s/\n([\w\(\)\-\.]+\:)/\n<b>$1<\/b>/g;
    text = text.gsub(/\n([\w\(\)\-\.]+\:)/) { |s| s = "<b>#{ s }</b>" }

    # ${$text}=~ s/\n(\s*\#.*)/\n<b class='comment'>$1<\/b>/g;

    text = text.gsub(/(\s*\#.*)/) { |s| s = "<b class='comment'>#{ s }</b>" }

    # ${$text}=~ s/\n\%(description|prep|build|install|preun|pre|postun|post|triggerpostun|trigger|files|changelog|package)([\n|\s])/\n<b class='reserved'>\%$1<\/b>$2/g;
    text = text.gsub(/^%(description|prep|build|check|install|preun|pre|postun|post|triggerpostun|trigger|files|changelog|package)/) { |s| s = "<b class='reserved'>#{ s }</b>" }

    # ${$text}=~ s/\n/<br \/>/g;
    text = text.gsub(/\n/, '<br>')

    # ${$text}=~ s/\r//g;
    text = text.gsub(/\r/, '')

    text.html_safe
    text
  end

  def menu_data branch, srpm, opened_bugs, all_bugs, version
    map = {
      main: {
         path: 'srpm_path',
         args: [branch, srpm],
         popup: 'information about SRPM'
      },
      changelog: {
         path: 'changelog_srpm_path',
         args: [branch, srpm],
         popup: 'full changelog',
      },
      spec: {
         path: 'spec_srpm_path',
         args: [branch, srpm],
         popup: 'spec',
      },
      patches: {
         path: 'srpm_patches_path',
         args: [branch, srpm],
         popup: 'patches',
      },
      sources: {
         path: 'srpm_sources_path',
         args: [branch, srpm],
         popup: 'sources',
      },
      download: {
         path: 'get_srpm_path',
         args: [branch, srpm],
         popup: 'download latest version',
      },
      gear: {
         path: 'gear_srpm_path',
         args: [branch, srpm],
         popup: 'this package in gear repositories',
      },
      bugs: {
         title: _('Bugs and FR (%s/%s)') % [opened_bugs.count, all_bugs.count],
         path: 'bugs_srpm_path',
         args: [branch, srpm],
         popup: 'list of bugs and feature requests',
         valid: 'perpetual?'
      },
      repocop: {
         path: 'repocop_srpm_path',
         args: [branch, srpm],
         popup: 'repocop bugreports',
         valid: 'perpetual?'
      }
    }

    map.map do |(title, data)|
      data[:path] = version && "versioned_" + data[:path] || data[:path]

      data[:title] ||= _(title.to_s.capitalize)

      [title, data]
    end.to_h
  end
end
