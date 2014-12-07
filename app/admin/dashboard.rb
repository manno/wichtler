ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "Welcome to The Wichtler"
        small "Admin Interface"
      end
    end

    columns do
      column do
        panel "Recent User changes" do
          ul do
            Person.order(:updated_at).limit(5).map do |person|
              li link_to(person.name, admin_people_path(person))
            end
          end
        end
      end
    end

  end # content

end
