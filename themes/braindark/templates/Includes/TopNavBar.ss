<div id="topNav">
    <div class="fixed">
        <div class="wrapper">
        <% if CurrentMember %>
         <div class="welcome"><a href="#" title=""><img src="$CurrentMember.photoUrl" width="21" height="21" alt="" /></a><span>Howdy, $CurrentMember.FirstName!</span></div>
<% end_if %>
           
            <div class="userNav">
                <ul>
                    <li><a href="host/profile" title=""><img src="themes/braindark/images/icons/topnav/profile.png" alt="" /><span>Profile</span></a></li>
                    <li><a href="host/chat" title=""><img src="themes/braindark/images/icons/topnav/messages.png" alt="" /><span>Chat</span><span class="numberTop">0</span></a></li>
                    <li class="dd"><img src="themes/braindark/images/icons/topnav/tasks.png" alt="" /><span>&#956;Messages</span></span>
                        <ul class="menu_body">
                            <li><a href="host/umsg?t=new" title="">new message</a></li>
                            <li><a href="host/umsg?t=new" title="">Qued Messages</a></li>
                        </ul>
                    </li>
                    <li><a href="host/settings" title=""><img src="themes/braindark/images/icons/topnav/settings.png" alt="" /><span>Settings</span></a></li>
                    <li><a href="host/logout" title=""><img src="themes/braindark/images/icons/topnav/logout.png" alt="" /><span>Logout</span></a></li>
                </ul>
            </div>
            <div class="fix"></div>
        </div>
    </div>
</div>
