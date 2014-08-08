domain = "http://localhost:3000"
stylesheet_url = domain + '/assets/bookmarklet.css'
stylesheet = new Element 'link',
                          rel: 'stylesheet'
                          href: stylesheet_url
                          type: 'text/css'

$$('head').first().appendChild(stylesheet)

alert('hi')

ll = {}
container = new Element('div')
ul = new Element('ul')
mp3 = false
title = $$('title').first().innerHTML
already_found_mp3 = false

mp3_links = []

add_source = (source) ->
  return if already_found_mp3
  s = new Element('input', {'type': 'checkbox', 'name': 'source[url]', 'value': source, 'checked': 'checked', 'class': 'checkbox'})
  t = new Element('input', {'type': 'text', 'name': 'source[title]', 'value': title, 'class': 'textfield ll_title'})
  l = new Element('input', {'type': 'text', 'name': 'source[url]', 'value': source, 'class': 'textfield ll_title'})
  u = new Element('input', {'type': 'hidden', 'name': 'username', 'value': ll_username, 'class': 'hidden ll_username'})
  ui = new Element('input', {'type': 'hidden', 'name': 'source[user_id]', 'value': ll_userid, 'class': 'hidden ll_username'})
  sub = new Element('input', {'type': 'checkbox', 'name': 'source[subscription_url]', 'value': "", 'class': 'hidden subscription_url'})

  dt = $$('title').first()
  t.value = dt.innerHTML if dt

  li = new Element('li')
  #li.appendChild(s)
  li.appendChild(t)
  li.appendChild(l)
  li.appendChild(u)
  li.appendChild(ui)

  txt = new Element('span')
  txt.innerHTML = source.slice(-10)
  #li.appendChild(txt)
  ul.appendChild(li)
  already_found_mp3 = true

#fix_position = (element) ->
#   if $(element) != null) ->
#      if(typeof window.innerHeight != 'undefined') ->
#         $(element).style.top =
#              Math.round(document.viewport.getScrollOffsets().top +
#              ((window.innerHeight - $(element).getHeight()))/2)+'px';
#         $(element).style.left =
#              Math.round(document.viewport.getScrollOffsets().left +
#              ((window.innerWidth - $(element).getWidth()))/2)+'px';
#      else
#         $(element).style.top =
#              Math.round(document.body.scrollTop +
#              (($$('body')[0].clientHeight - $(element).getHeight()))/2)+'px';
#         $(element).style.left =
#              Math.round(document.body.scrollLeft +
#              (($$('body')[0].clientWidth - $(element).getWidth()))/2)+'px';


add_subscription = (subscription_url) ->
   $$('.subscription_url').value = subscription_url


$$('a').each(link) ->
  add_source(link.href) if link.href.match('mp3')
  add_subscription(link.href) if link.href.match('rss' || 'atom')

# if ! mp3
#   $$('object').each(o) ->
#     o.select('param').each(p) ->
#       if p.value.match('mp3')
#         e = /((http|ftp):\\\\\\\\/)?\\\\\\\\/?([^:\\\\\\\\/\\\\\\\\s]+)((\\\\\\\\/\\\\\\\\w+)*\\\\\\\\/)([\\\\\\\\w\\\\\\\\-\\\\\\\\.]+\\\\\\\\.[^#?\\\\\\\\s]+)(#[\\\\\\\\w\\\\\\\\-]+)?/
#         matched = p.value.match(e)
#         add_source(matched.first()) if matched
#
#

f = new Element('form', {'action': ''+ll_domain+'/users/'+ll_userid+'/sources', 'method': 'post'})
f.appendChild(ul)
b = new Element('input', {'type': 'submit', 'value': 'Listen Later', 'class': 'll_button'})
f.appendChild(b)
a = new Element('input', {'name': 'authenticity_token', 'type': 'hidden', 'value': ll_auth_token });
f.appendChild(a)
container.id = 'listenlater'

container.appendChild(f)
document.body.appendChild(container)
container.addClassName('listenlater_active')

$(f).observe 'submit', (e) ->
  new Ajax.Request f.action, {
                    parameters: f.serialize(),
                    onSuccess: ->
                      container.innerHTML = "Saved for your later listening pleasure!"
                  }

  e.stop()



