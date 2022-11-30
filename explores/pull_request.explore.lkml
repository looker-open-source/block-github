include: "/views/pull_request.view"
include: "/views/issue.view"
include: "/views/repository.view"
include: "/views/requested_reviewer_history.view"
include: "/views/pull_request_review.view"
include: "/views/pull_request_review_dismissed.view"
include: "/views/user.view"
include: "/views/commit.view.lkml"

explore: pull_request {
  join: issue {
    from: user
    type: left_outer
    sql_on: ${pull_request.issue_id} = ${issue.id} ;;
    relationship: many_to_one
  }
  join: repository {
    type: left_outer
    sql_on: ${pull_request.base_repo_id} = ${repository.id} ;;
    relationship: many_to_one
  }
  join: requested_reviewer_history {
    type: left_outer
    sql_on: ${pull_request.id} = ${requested_reviewer_history.pull_request_id} ;;
    relationship: one_to_many
  }
  join: pull_request_review {
    type: left_outer
    sql_on: ${pull_request.id} = ${pull_request_review.pull_request_id};;
    relationship: one_to_many
  }
  join: reviewer {
    fields: [reviewer.name]
    from: user
    type: left_outer
    sql_on: ${reviewer.id} = ${pull_request_review.user_id} ;;
    relationship: many_to_one
  }
  join: pull_request_review_dismissed {
    type: left_outer
    sql_on: ${pull_request_review_dismissed.pull_request_review_id} = ${pull_request_review.id} ;;
    relationship: one_to_one
  }
  join: pull_request_head_user {
    view_label: "Pull Request"
    fields: [pull_request_head_user.head_user_name]
    from: user
    type: left_outer
    sql_on: ${pull_request_head_user.id} = ${pull_request.head_user_id} ;;
    relationship: many_to_one
  }
  join: repository_head {
    view_label: "Pull Request"
    fields: [repository_head.head_repo_name]
    from: repository
    type: left_outer
    sql_on: ${repository_head.id} = ${pull_request.head_repo_id} ;;
    relationship: many_to_one
  }
  join: merge_commit {
    view_label: "Merge commit"
    from: commit
    type: left_outer
    sql_on ${pull_request.merge_commit_sha} = ${commit.sha} ;;
    relationship: many_to_one
  }

}
