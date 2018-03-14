class TransferDecorator < Draper::Decorator
  delegate_all

  STATUS_ICONS = {
    pending: ['glyphicon glyphicon-time', 'text-warning'],
    completed: ['glyphicon glyphicon-ok', 'text-success'],
    failed:   ['glyphicon glyphicon-remove', 'text-danger'],
    error:   ['glyphicon glyphicon-fire', 'text-danger'],
  }.freeze

  def status_icon
    h.content_tag(:span, nil, class: STATUS_ICONS[status.to_sym], title: status_text)
  end
end
