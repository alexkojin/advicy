class DropUnneededTablesAndModels < ActiveRecord::Migration[5.0]
  def self.up
    drop_table 'badges'
    drop_table 'companies'
    drop_table 'connections'
    drop_table 'educations'
    drop_table 'experiences'
    drop_table 'jobs'
    drop_table 'job_roles'
    drop_table 'job_skills'
    drop_table 'ownedbadges'
    drop_table 'relationships'
    drop_table 'roles'
    drop_table 'skills'
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
