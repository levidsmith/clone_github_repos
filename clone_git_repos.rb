#2020 Levi D. Smith - levidsmith.com

require 'json'

USER='**********'
#Generate a token from https://github.com/settings/tokens with repo read access
API_TOKEN='****************************************' 
GIT_API_URL='https://api.github.com'
CLONE_DIR='D:\\*******\\********\\'
REPO_LIST_JSON='repos.json'
REPO_LIST_TXT='repos.txt'

def iterate_repo_pages(strURL)
  puts "processing URL: " + strURL
  get_repo_urls(strURL)


  strHeader = `curl -s -I -H "Authorization: token #{API_TOKEN}" #{strURL}` 
  puts strHeader


  for strLine in strHeader.split("\n")
    matchdata = strLine.match(/Link: .*<(.+)>; rel=\"next\".*<(.+)>; rel=\"last\".*/)
    if (matchdata)
      puts "matchdata next: #{matchdata[1]} last: #{matchdata[2]}"
      strNextLink = matchdata[1]
      strLastLink = matchdata[2]
      iterate_repo_pages(strNextLink) 
    end
  end

end


def get_repo_urls(strURL)
  puts "Getting repo URLs"
  system 'curl -s -H "Authorization: token ' + API_TOKEN + '" ' + strURL + ' > ' + REPO_LIST_JSON

  make_repo_list()

end

def make_repo_list()
  fReposJson = File.open(REPO_LIST_JSON, 'r')
  strJsonContents = fReposJson.read
  fReposJson.close

  fReposText = File.open(REPO_LIST_TXT, 'a')

  repos = JSON.parse(strJsonContents)
  repos.map do | repo |
    strUrl = repo["html_url"]
    puts "Repo URL: " + strUrl 
    fReposText.write(strUrl + "\n")
  end

  fReposText.close


end


def check_out_repos()

  puts "Checking out repos"
  f = File.open(REPO_LIST_TXT, 'r')
  strContents = f.read
  f.close


  for strLine in strContents.split("\n")
    strURL = strLine.strip
    strFolder = strLine.strip.split('/')[-1] #-1 gets last element of the array
    strCommand = "git clone #{strURL} #{CLONE_DIR}#{strFolder}"
    puts strCommand
    system(strCommand)
  end
end

puts "GitHub repository clone"
puts "2020 Levi D. Smith - levidsmith.com"

if (File.exist?(REPO_LIST_TXT))
  File.delete(REPO_LIST_TXT)
end
iterate_repo_pages('https://api.github.com/user/repos')

check_out_repos()
