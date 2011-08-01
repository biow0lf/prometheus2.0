require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "should return '/en' for url '/' and lang 'en'" do
    assert_equal('/en', current_page('/', 'en'))
  end

  test "should change '/en/project' to '/ru/project'" do
    assert_equal('/ru/project', current_page('/en/project', 'ru'))
  end
end
