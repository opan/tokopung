# desc "Explaining what the task does"
# task :core do
#   # Task goes here
# end

Rake::Task["db:seed"].enhance ["seeding"]

task :seeding => :environment  do
  # delete all role first, make sure theres no duplication
  Mesin::Role.destroy_all

  # create default role "Superadmin"
  superadmin = Mesin::Role.create({role_name: "superadmin", it_can_be_deleted: false, 
    created_at: DateTime.now, updated_at: DateTime.now, role_id_parent: 0, role_title: "Superadmin"})

  # create default role "Admin"
  admin = Mesin::Role.create({role_name: "admin", it_can_be_deleted: true, created_at: DateTime.now, updated_at: DateTime.now, 
    role_id_parent: superadmin.id, role_title: "Admin"})

  # create default role "Customer"
  customer = Mesin::Role.create({role_name: "customer", it_can_be_deleted: true, created_at: DateTime.now, updated_at: DateTime.now, 
    role_id_parent: admin.id, role_title: "Customer", is_default: true})
end
