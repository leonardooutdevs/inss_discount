module SidebarHelper
  def links
    [
      admins,
      proponents,
      address
    ]
  end

  def admins
    {
      id: 'admins',
      name: t('.users.title'),
      items: [
        { name: t('.users.index'), path: url_for([:users]) },
        { name: t('.access_permissions.index'), path: url_for([:access_permissions]) },
        { name: t('.access_levels.index'), path: url_for([:access_levels]) }
      ]
    }
  end

  def proponents
    {
      id: 'proponent',
      name: t('.proponents.title'),
      items: [
        { name: t('.proponents.reports.title'), path: reports_proponents_path },
        { name: t('.proponents.title'), path: url_for([:proponents]) },
        { name: t('.salaries.title'), path: url_for([:salaries]) }
      ]
    }
  end

  def address
    {
      id: 'address',
      name: t('.address.title'),
      items: [
        { name: t('.address.countries.title'), path: url_for([:countries]) },
        { name: t('.address.states.title'), path: url_for([:states]) },
        { name: t('.address.cities.title'), path: url_for([:cities]) }
      ]
    }
  end

  def sidebar
    content_tag :nav, id: 'sidebarMenu', class: 'col-md-3 col-lg-2 d-md-block bg-body-tertiary sidebar collapse' do
      content_tag :div, class: 'flex-shrink-0 p-3' do
        content_tag :ul, class: 'list-unstyled ps-0' do
          links.map do |link|
            sidebar_group_by(*link.values)
          end.join.try(:html_safe)
        end
      end
    end
  end

  def sidebar_group_by(id, name, items)
    content_tag :li, class: 'mb-1' do
      group_name(id, name) + group_options(id, items)
    end
  end

  def group_name(id, name)
    content_tag(
      'button',
      class: 'btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed',
      'data-bs-toggle': 'collapse', 'data-bs-target': "##{id}-collapse", 'aria-expanded': true
    ) do
      name
    end
  end

  def group_options(id, items)
    content_tag(:div, class: 'collapse show', id: "#{id}-collapse", style: '') do
      content_tag :ul, class: 'btn-toggle-nav list-unstyled fw-normal pb-1 small' do
        items.map do |item|
          content_tag(:li) do
            link_to item[:name], item[:path],
                    class: 'link-body-emphasis d-inline-flex text-decoration-none rounded', data: { turbo: false }
          end
        end.join.try(:html_safe)
      end
    end
  end
end
