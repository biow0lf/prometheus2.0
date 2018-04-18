# frozen_string_literal: true

class SearchIndex < ActiveRecord::Migration[5.1]
  def change
    add_column :pg_search_documents, :tsv_body, :tsvector

    add_index :pg_search_documents, :tsv_body, using: 'gin'
  end
end
