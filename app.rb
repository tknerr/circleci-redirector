require 'sinatra'
require 'open-uri'
require 'json'
require 'redcarpet'
require 'sinatra/reloader' if development?

get '/todo' do
  markdown :todo
end

get '/' do
  markdown :index
end

get '/:user/:project/tree/:branch/latest' do |user, project, branch|
  latest = latest_build(user, project, branch)
  ok fetch_build_details(user, project, latest['build_num'])
end

get '/:user/:project/tree/:branch/latest/id' do |user, project, branch|
  latest = latest_build(user, project, branch)
  ok latest['build_num'].to_s
end

get '/:user/:project/tree/:branch/latest/artifacts' do |user, project, branch|
  latest = latest_build(user, project, branch)
  if (latest['has_artifacts'] == true)
    ok fetch_build_artifacts(user, project, latest['build_num'])
  else
    not_found 'no artifacts for this build'
  end
end

get '/:user/:project/tree/:branch/latest/artifacts/:artifact' do |user, project, branch, artifact|
  latest = latest_build(user, project, branch)
  if (latest['has_artifacts'] == true)
    found_artifact = find_artifact(user, project, latest['build_num'], artifact)
    if found_artifact
      # do a browser redirect here because the artifacts might be huge
      redirect to(found_artifact['url'])
    else
      not_found 'no such artifact'
    end
  else
    not_found 'no artifacts for this build'
  end
end


def ok(body)
  [200, {'Content-Type' => 'text/plain'}, body]
end

def not_found(message)
  [404, {'Content-Type' => 'text/plain'}, message]
end

def latest_build(user, project, branch)
  JSON.parse(fetch_build_summaries(user, project, branch, 1)).first
end

def find_artifact(user, project, build_num, artifact_name)
  artifacts = JSON.parse(fetch_build_artifacts(user, project, build_num))
  artifacts.find { |it| it['pretty_path'].end_with? artifact_name }
end

def fetch_build_summaries(user, project, branch, limit = 30)
  fetch("https://circleci.com/api/v1/project/#{user}/#{project}/tree/#{branch}?limit=#{limit}")
end

def fetch_build_details(user, project, build_num)
  fetch("https://circleci.com/api/v1/project/#{user}/#{project}/#{build_num}")
end

def fetch_build_artifacts(user, project, build_num)
  fetch("https://circleci.com/api/v1/project/#{user}/#{project}/#{build_num}/artifacts")
end

def fetch(url)
  open(url).read
end
