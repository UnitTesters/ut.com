<%include 'common_header.gsp'%>

	<div class="page-header">
		<h1>All Categories</h1>
	</div>
	<div class="category-posts">
		<ul>
		<%content.categories.each {category,path ->%>
			<li><a href="${content.rootpath}${path}"/>${category}</a></li>
		<%}%>
		</ul>
		</div>

<%include "footer.gsp"%>
