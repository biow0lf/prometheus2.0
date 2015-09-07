require 'rails_helper'

describe Api::BugsController do
end

=begin

                                       Prefix Verb   URI Pattern                                                        Controller#Action
                                     api_docs GET    /api/docs(.:format)                                                api/docs#index {:format=>"json"}
                                      api_bug GET    /api/bugs/:id(.:format)                                            api/bugs#show {:format=>"json"}
                                     api_srpm GET    /api/srpms/:id(.:format)                                           api/srpms#show {:format=>"json", :id=>/[^\/]+/}

=end
