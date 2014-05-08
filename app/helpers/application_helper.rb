module ApplicationHelper
  def sort_button(column, order = {column: 'id', type: 'asc'})
#      concat '&nbsp;'.html_safe
    content_tag(:div, :class => 'sort-col') do
      concat image_tag("/assets/sort_asc#{ '_on' if order[:column] == column and order[:type] == 'asc'}.png", {class: 'sort-btn', data: {column: column, type: 'asc'}})
      concat tag('br')
      concat image_tag("/assets/sort_dsc#{ '_on' if order[:column] == column and order[:type] == 'desc'}.png", {class: 'sort-btn', data: {column: column, type: 'desc'}})
    end         
  end                                             
end

class NilClass
  def to_s(*args)
    ""
  end
end