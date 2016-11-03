<%include 'common_header.gsp'%>


	<div class="page-header">
		<h1>${content.title}</h1>
	</div>

	<p><em>${content.date.format("dd MMMM yyyy")}</em></p>

	<p>${content.body}</p>

	<hr />
<%include "github_comments.gsp"%>

<%include "footer.gsp"%>
