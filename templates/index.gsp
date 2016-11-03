<%include 'common_header.gsp'%>


	<%published_posts.each {post ->%>
		<div class="post-preview">
			<a href="${post.permalink}" class="plain post-title">
				${post.title}
			</a>
			<p class="post-meta">Published by <% print post.author? post.author: config.default_author  %> on ${post.date.format("dd MMMM yyyy")} under <a href="/${config.categories_path}/<% print post.primary_category.replaceAll(' ','-') %>">${post.primary_category}</a>
		</p>
			<p class="post-content"> <% if (post.summary) {%> ${post.summary}
						<% } else {%>
					<% print post.body.length() > 100 ? post.body[0..100] : post.body } %>
					...<span class="read-more"><a href="${post.permalink}">Read More</a></span>
			</p>
			<hr/>
		</div>
		<%}%>


		<!-- Pager -->
    <ul class="pager">
        <li class="next">
            <a href="/${config.archive_file}" class="plain">Older Posts &rarr;</a>
        </li>
    </ul>

<%include "footer.gsp"%>
