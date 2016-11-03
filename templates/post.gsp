<%include 'common_header.gsp'%>
	
	<div class="post">
		<h1 class="post-title">${content.title}</h1>
		<p class="post-meta">Published by <% print content.author? content.author: config.default_author  %> on ${content.date.format("dd MMMM yyyy")} under <a href="/${config.categories_path}/<% print content.primary_category.replaceAll(' ','-') %>">${content.primary_category}</a>
		</p>
		
		<div class="post-summary">
			<p><% print content.summary ? content.summary : "" %></p>
		</div>
		<div>
			<p class="post-content"> ${content.body} </p>
		</div>
		<p class="post-tags"><% if (content.tags) { %> Tags:  <% content.tags.each {tag -> %><a href="/tags/${tag}.html">${tag}</a> <% } } %> </p>
		<%include "social-share-strip.gsp"%>
		
	</div>
	
	<%include "disqus.gsp"%>
	
<%include "footer.gsp"%>
