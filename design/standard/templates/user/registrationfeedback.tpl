{set-block scope=root variable=subject}{'New user registered at %siteurl'|i18n('design/standard/user/register',,hash('%siteurl',ezini('SiteSettings','SiteURL')))}{/set-block}
{'A new user has registered.'|i18n('design/standard/user/register')}

{'Account information.'|i18n('design/standard/user/register')}
{'Login'|i18n('design/standard/user/register','Login name')}: {$user.login}
{'Email'|i18n('design/standard/user/register')}: {$user.email}

{'Link to user information'|i18n('design/standard/user/register')}:
http://{$hostname}{concat('content/view/full/',$object.main_node_id)|ezurl(no)}
