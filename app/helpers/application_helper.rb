module ApplicationHelper
  def bookmarklet_string
   str = "  javascript:function "
   str << " loadScript(scriptURL) { var scriptElem = document.createElement('SCRIPT'); scriptElem.setAttribute('language', 'JavaScript'); scriptElem.setAttribute('src', scriptURL);document.body.appendChild(scriptElem);} " 

   str << " loadScript('#{noconflict_jquery_url}');"
   str << " loadScript('#{bookmarklet_url(:format => :js)}'); "
   str
  end

  def noconflict_jquery_url
   "http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" 
  end

  def active_user
    current_user || NullUser.new
  end
end
