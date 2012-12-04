# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def pagination_links_remote(paginator)
    page_options = {:window_size => 1}
    pagination_links_each(paginator, page_options) do |n|
      options = {
        :url => {:action => 'list', :params => params.merge({:page => n})},
        :update => 'table',
        :before => "Element.show('spinner')",
        :success => "Element.hide('spinner')"
      }
      html_options = {:href => url_for(:action => 'list', :params => params.merge({:page => n}))}
      link_to_remote(n.to_s, options, html_options)
    end
  end

  def generate_list_header(pagination, filter, table_class="list_table")
    html = "<table class=\"#{table_class}\">"
    html += "<tr>"
    html += "<td>"
    html += filter if !filter.nil?
    html += "</td>"
    html += "<td style=\"text-align: right;\">"
    html += pagination if !pagination.nil?
    html += "</td>
             </tr>
             </table>"
    return html
  end

  def filter_by_project(current_filter, projects)
    html = ""
    if !current_filter.nil?
      link = link_to_remote 'All', :url=>{:action=>'list', :params=>params.merge({ :filter=>nil })}, :update=>'list'
      html += "#{link} "
    else
      html += "All "
    end
    projects.each do |project|
        if project.id.to_s != current_filter
          options = {
            :url => {:action=>'list', :params=>params.merge({:filter=>project.id})},
            :update=>'list'
          }
          html_options = {:href=>url_for(:action=>'list', :params=>params.merge({:filter=>project.id}))}
          link = link_to_remote(project.name, options, html_options)
          html +=  "#{link} "
        else
          html += "#{project.name} "
        end
    end
    return html
  end

  def site_revision
    "1.5.0.0"
  end

end
