# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Contributor.destroy_all
HostUser.destroy_all
Forum.destroy_all
Discussion.destroy_all


# Create testing contributor
test_contributor = Contributor.new(email: "contributor@example.com", username: "test_contributor", password: "password")
test_contributor.save
# Create testing contributor with username only, no email.
test_contributor_username_only = Contributor.new(username: "test_no_email", password: "password")
test_contributor_username_only.save

# Create bulk contributors
20.times do
  contributor = Contributor.new(email: Faker::Internet.safe_email, username: Faker::Internet.user_name, password: Faker::Internet.password(8))
  contributor.save
end

# Store reference to all contributors for use in generating comments later
allContributors = Contributor.all


# Create specific Test Host Users that I know the details of...
admin_user = HostUser.new(email: 'admin@example.com', password: "password")
admin_user.save
4.times do
  forum = Forum.new(root_domain: Faker::Internet.domain_name, forum_shortname: Faker::App.name, host_user_id: admin_user.id)
  forum.save
  # Create some discussions
  Random.rand(2..20).times do
    discussion = Discussion.new(forum_id: forum.id, page_url: Faker::Internet.url(forum.root_domain))
    discussion.save

    # Create a bunch of comments for each discussion. In this case they are assumed as not pending,a nd with status approved
    Random.rand(0..20).times do
      comment = Comment.new(discussion_id: discussion.id, contributor_id: allContributors[Random.rand(0..allContributors.count-1)].id, body_text: Faker::Lorem.paragraph, created_at_readable: Time.now.strftime("%B %-d %Y, %-l:%M%P"))
      comment.save
    end
  end
end

# Create bulk Host Users and associated Formums/Discussions
20.times do
  user = HostUser.new(email: Faker::Internet.safe_email, password: "password")
  user.save
  # Create Forums for each User
  Random.rand(1..3).times do
    forum = Forum.new(root_domain: Faker::Internet.domain_name, forum_shortname: Faker::App.name, host_user_id: user.id)
    forum.save
    # Create Discussions for each Forum
    Random.rand(2..20).times do
      discussion = Discussion.new(forum_id: forum.id, page_url: Faker::Internet.url(forum.root_domain))
      discussion.save
      # Create a bunch of comments for each discussion. In this case they are assumed as not pending,a nd with status approved
      Random.rand(0..20).times do
        comment = Comment.new(discussion_id: discussion.id, contributor_id: allContributors[Random.rand(0..allContributors.count-1)].id, body_text: Faker::Lorem.paragraph, created_at_readable: Time.now.strftime("%B %-d %Y, %-l:%M%P"))
        comment.save
      end
    end
  end
end
