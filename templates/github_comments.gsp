<% if (config.github_comments && content.githubIssueId) { %>
<section class="comments">
	<hr/>
	<div id="comments_count_header"></div>
	<div id="comments_ask">
		Have something to say? Add a comment to <a href="https://github.com/${config.github_username}/${config.github_issues_repo}/issues/${content.githubIssueId}"> this post's issue page on GitHub</a> (you'll need a GitHub account. You have one, right!).
	</div>
  <div id="comments_thread"></div>
  <script type="text/javascript">
    var githubIssueId = '${content.githubIssueId}';

	function displayComments(data) {
		\$("#comments_count_header").append("<h3>" + data.length + " Comments</h3>");
      	for (var i=0; i<data.length; i++) {
        var user = data[i].user.login;
        var profileLink = "https://www.github.com/" + data[i].user.login;
        var commentUrl = data[i].html_url;
       	var commentBody = data[i].body_html;
       	var userAvatar = data[i].user.avatar_url;
      	var commentDate = new Date(data[i].created_at).toUTCString();
      	
 
       \$("#comments_thread").append("<div class='comment'><div class='commentheader'>" + '<img src="' + userAvatar + '" alt="' + user + '" width="20" height="20">' + "<a class='commentuser plain' href=\""+ profileLink + "\">" + user + "</a><a class='commentdate plain' href=\"" + commentUrl + "\">" + commentDate + "</a></div><div class='commentbody'>" + commentBody + "</div></div>");
     }
   }

	  \$.ajax("https://api.github.com/repos/${config.github_username}/${config.github_issues_repo}/issues/${content.githubIssueId}/comments", {
 				headers: {Accept: "application/vnd.github.full+json"},
     			success: function(msg){
       			displayComments(msg);
    		}});
  </script>
  
</section>
<% } %>
