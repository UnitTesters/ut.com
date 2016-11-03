<head>
  <meta charset="utf-8"/>
  <title><%if (content.title) {%>${content.title}<% } else { %>${config.site_name}<% }%></title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="<% print content.summary ? content.summary : content.author %>">
  <meta name="author" content="${content.author}">
  <meta name="keywords" content="${content.tags}">
  <meta name="generator" content="JBake">

  <link href="https://fonts.googleapis.com/css?family=Rokkitt" rel="stylesheet">
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
  <!-- Le styles -->
  <link href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/css/asciidoctor.css" rel="stylesheet">
  <link href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/css/base.css" rel="stylesheet">
  <link href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/css/prettify.css" rel="stylesheet">

	<script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/js/jquery-1.11.1.min.js"></script>
    <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/js/bootstrap.min.js"></script>
    <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/js/prettify.js"></script>
	

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/js/html5shiv.min.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
  <link rel="apple-touch-icon" sizes="57x57" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"  href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/favicon-16x16.png">
<link rel="manifest" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">
  <link rel="shortcut icon" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>resources/ico/favicon.ico">
  
<!-- Begin Cookie Consent plugin by Silktide - http://silktide.com/cookieconsent -->
<script type="text/javascript">
    window.cookieconsent_options = {"message":"This website uses cookies to ensure you get the best experience on our website. If you continue to use this site, you agree to our use of cookies.","dismiss":"Got it!","learnMore":"More info","link":"/terms-usage-privacy/","theme":"dark-floating"};
</script>

<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/cookieconsent2/1.0.10/cookieconsent.min.js"></script>
<!-- End Cookie Consent plugin -->

  
</head>
