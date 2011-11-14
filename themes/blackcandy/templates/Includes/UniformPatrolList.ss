<li>
	<h3>Uniform Patrol Contacts</h3>
	<% if PatrolContacts %>
	<ul data-role="listview" data-filter="true">
		<% control PatrolContacts %>
		<li>
			<div data-role="collapsible" data-theme="d" data-content-theme="b">
				<h3>$Unit</h3>
				<div class="AddressBlock">
					<h4>Address</h4>
					<p>$Address</p>
				</div>
				<div class="AddressBlock">
					<div class="ui-grid-a">
					<div class="ui-block-a"><h4>Phone</h4></div>
					<div class="ui-block-b"><h4>Email</h4></div>
					</div>
					<div class="ui-grid-a">
					<div class="ui-block-a">$Phone</div>
					<div class="ui-block-b">$Email</div>
					</div>
				</div>
			</div>
		</li>
		<% end_control %>
	</ul>
	<% end_if %>
</li>
