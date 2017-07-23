# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if FocusType.count < 5
  FocusType.create(name: 'Clinical', description: 'The lab focuses on clinical applications, areas, or patients/families.')
  FocusType.create(name: 'Team', description: 'The lab focuses on improving a team (or teams) workflow or tools.')
  FocusType.create(name: 'Technical Debt', description: 'The lab focuses on reducing or eliminating technical debt.')
  FocusType.create(name: 'Building/Workspace', description: 'The lab focuses on improving building or workspace conditions or an event for the build or department.')
  FocusType.create(name: 'Other', description: 'The lab focus is something other than the provided options. Please provide additional detail in the project goals.')
end

if RoleType.count < 6
  RoleType.create(name: 'project manager')
  RoleType.create(name: 'web designer')
  RoleType.create(name: 'web developer')
  RoleType.create(name: 'programmer')
  RoleType.create(name: 'dba')
  RoleType.create(name: 'technical writer')
end

if SuggestionState.count < 5
  SuggestionState.create(name: 'submitted')
  SuggestionState.create(name: 'reviewing')
  SuggestionState.create(name: 'implementing')
  SuggestionState.create(name: 'rejected', done: true)
  SuggestionState.create(name: 'completed', done: true)
end
