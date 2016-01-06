require 'sinatra'
require 'open-uri'
require 'json'
require 'redcarpet'
require 'uri'
require 'sinatra/reloader' if development?

get '/todo' do
  markdown :todo
end

get '/' do
  markdown :index
end

get '/api/v1/project/:user/:project/tree/:branch/latest' do |user, project, branch|
  latest = latest_build(user, project, branch)
  redirect_to build_details(user, project, latest['build_num'])
end

get '/api/v1/project/:user/:project/tree/:branch/latest/artifacts' do |user, project, branch|
  latest = latest_build(user, project, branch)
  redirect_to build_artifacts(user, project, latest['build_num'])
end

get '/api/v1/project/:user/:project/tree/:branch/latest/tests' do |user, project, branch|
  latest = latest_build(user, project, branch)
  redirect_to build_testresults(user, project, latest['build_num'])
end

get '/api/v1/project/:user/:project/tree/:branch/latest/artifacts/:artifact' do |user, project, branch, artifact|
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

get '/api/v1/*' do |path|
  redirect_to circleci_api(path)
end


helpers do

  def not_found(message)
    [404, {'Content-Type' => 'text/plain'}, message]
  end

  def redirect_to(url)
    redirect to(preserve_query(url))
  end

  def fetch(url)
    open(preserve_query(url)).read
  end

  def latest_build(user, project, branch)
    JSON.parse(fetch(build_summaries(user, project, branch, 1))).first
  end

  def find_artifact(user, project, build_num, artifact_name)
    artifacts = JSON.parse(fetch(build_artifacts(user, project, build_num)))
    artifacts.find { |it| it['pretty_path'].end_with? artifact_name }
  end

  def circleci_api(path)
    "https://circleci.com/api/v1/#{path}"
  end

  def build_summaries(user, project, branch, limit = 30)
    circleci_api("project/#{user}/#{project}/tree/#{branch}?limit=#{limit}")
  end

  def build_details(user, project, build_num)
    circleci_api("project/#{user}/#{project}/#{build_num}")
  end

  def build_artifacts(user, project, build_num)
    circleci_api("project/#{user}/#{project}/#{build_num}/artifacts")
  end

  def build_testresults(user, project, build_num)
    circleci_api("project/#{user}/#{project}/#{build_num}/tests")
  end

  def preserve_query(url)
    uri = URI(url)
    current_params = URI.decode_www_form(uri.query || '')
    original_params = URI.decode_www_form(request.query_string || '')
    merged_params = URI.encode_www_form(current_params + original_params)
    uri.query = merged_params unless merged_params.empty?
    uri.to_s
  end
end
