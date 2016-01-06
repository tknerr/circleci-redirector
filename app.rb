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

get '/api/v1/:user/:project/tree/:branch/latest' do |user, project, branch|
  latest = latest_build(user, project, branch)
  redirect_to build_details(user, project, latest['build_num'])
end

get '/api/v1/:user/:project/tree/:branch/latest/artifacts' do |user, project, branch|
  latest = latest_build(user, project, branch)
  if (latest['has_artifacts'] == true)
    redirect_to build_artifacts(user, project, latest['build_num'])
  else
    not_found 'no artifacts for this build'
  end
end

get '/api/v1/:user/:project/tree/:branch/latest/artifacts/:artifact' do |user, project, branch, artifact|
  latest = latest_build(user, project, branch)
  if (latest['has_artifacts'] == true)
    found_artifact = find_artifact(user, project, latest['build_num'], artifact)
    if found_artifact
      redirect_to found_artifact['url']
    else
      not_found 'no such artifact'
    end
  else
    not_found 'no artifacts for this build'
  end
end

def not_found(message)
  [404, {'Content-Type' => 'text/plain'}, message]
end

def redirect_to(url)
  unless request.query_string.empty?
    url << '?' << request.query_string
  end
  redirect to(url)
end

def latest_build(user, project, branch)
  JSON.parse(fetch(build_summaries(user, project, branch, 1))).first
end

def find_artifact(user, project, build_num, artifact_name)
  artifacts = JSON.parse(fetch(build_artifacts(user, project, build_num)))
  artifacts.find { |it| it['pretty_path'].end_with? artifact_name }
end

def build_summaries(user, project, branch, limit = 30)
  "https://circleci.com/api/v1/project/#{user}/#{project}/tree/#{branch}?limit=#{limit}"
end

def build_details(user, project, build_num)
  "https://circleci.com/api/v1/project/#{user}/#{project}/#{build_num}"
end

def build_artifacts(user, project, build_num)
  "https://circleci.com/api/v1/project/#{user}/#{project}/#{build_num}/artifacts"
end

def fetch(url)
  open(url).read
end
