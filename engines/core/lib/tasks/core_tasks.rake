# desc "Explaining what the task does"
# task :core do
#   # Task goes here
# end

Rake::Task["db:seed"].enhance ["seeding"]

task :seeding => :environment  do
  # delete all role first, make sure theres no duplication
  Mesin::Role.destroy_all

  Mesin::Role.create([
    {role_name: "admin", it_can_be_deleted: false, created_at: DateTime.now, updated_at: DateTime.now}, 
    {role_name: "super_admin", it_can_be_deleted: false, created_at: DateTime.now, updated_at: DateTime.now}
  ])
end
