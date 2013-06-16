class RepocopDecorator < Draper::Decorator
  delegate_all

  def show_message
    if object.message
      object.message
    else
      '&nbsp;'
    end
  end
end
