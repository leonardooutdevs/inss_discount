module FormHelper
  INSS_LOGO_URL = ENV.fetch('INSS_LOGO_URL', '')

  def validation_class(errors)
    errors.any? ? 'is-invalid' : 'is-valid'
  end

  def link_to_add_fields(name, form_object, association)
    new_object = build_new_object(form_object, association)
    fields = generate_fields(form_object, association, new_object)
    link_to_add(name, fields)
  end

  private

  def build_new_object(form_object, association)
    new_object = form_object.object.send(association).klass.new
    method = "build_#{association.to_s.split('_').last.singularize}"
    new_object.send(method)
    new_object
  end

  def generate_fields(form_object, association, new_object)
    form_object.simple_fields_for(association, new_object, child_index: new_object.object_id) do |builder|
      render("#{association.to_s.singularize}_fields", f: builder)
    end
  end

  def link_to_add(name, fields)
    data = { action: 'click->fields#add', fields: fields.gsub("\n", '') }
    link_to(name, '#', class: 'add_fields btn btn-outline-primary', data:)
  end
end
