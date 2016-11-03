    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-custom navbar-fixed-top">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                
                <a class="navbar-brand plain" href="/" class="plain">
                	<img src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/icon.png" alt="" class="site-logo img-responsive"/>${config.site_title}
                </a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                	<li>
                        <a class="plain" href="/">Home</a>
                    </li>
                    <li class="dropdown">
			          <a href="#" class="dropdown-toggle plain" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Categories <span class="caret"></span></a>
			          <ul class="dropdown-menu">
			            <% all_categories.each {category ->%>
								<li><a class="plain" href="/${config.categories_path}/<% print category.replaceAll(' ','-') %>"/>${category}</a></li>
							<%}%>
			          </ul>
			        </li>
			        <li>
                        <a class="plain" href="/${config.archive_file}">All Posts</a>
                    </li>
                    
                    <li>
                        <a class="plain" href="http://eepurl.com/b-IJAD" target="_blank">Subscribe</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

