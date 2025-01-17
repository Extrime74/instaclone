# frozen_string_literal: true

class CreateFollowabilityRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :followability_relationships do |t|
      t.belongs_to :followerable, polymorphic: true, null: false
      t.belongs_to :followable, polymorphic: true, null: false
      t.integer :status

      t.timestamps
    end
  end
end
