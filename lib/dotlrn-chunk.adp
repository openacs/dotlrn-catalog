<table>
<tr>
   <td>
     <table>
     <tr><td><b>#dotlrn-catalog.dep_name#:</b></td><td>@department_name;noquote@</td></tr>
     <tr><td><b>#dotlrn-catalog.term_name#:</b></td><td>@term_name;noquote@</td></tr>
     <tr><td><b>#dotlrn-catalog.subject_name#:</b></td><td>@class_name;noquote@</td></tr>
     <tr><td><b>#dotlrn-catalog.class_name#:</b></td><td><a href="@url@">@pretty_name;noquote@</a></td></tr>
     <tr><td><b>#dotlrn-catalog.description#:</b></td><td>@description;noquote@</td></tr>
     </table>
    </td>
    <td>
    <table>
      <tr>
         <td valign="top">
    	  <if @n_profs@ gt 0>
	      <ul>
	      @instructor_role_pretty_plural@:
	      <multiple name="users">
	       <if @users.rel_type@ eq "dotlrn_instructor_rel">
	        <li>
	          <%= [acs_community_member_link -user_id $users(user_id) -label "$users(first_names) $users(last_name)"] %>
	 	  <if @email_p@ eq 1>
	            (<%= [email_image::get_user_email -user_id $users(user_id)] %>)
		  </if>
                  <else>
	            (<a href="mailto:@users.email@">@users.email@</a>)
		  </else>
	        </if>
	      </multiple>
	    </if>
	    <else>
	      <li><small>#dotlrn-portlet.no_instructor_members#</small>
	    </else>
	    </ul>
            </td></tr>
	    <tr>
            <td valign="top">
	      <if @n_tas@ gt 0>
	       <ul>
	       @teaching_assistant_role_pretty_plural@:
		 <multiple name="users">
		   <if @users.rel_type@ eq "dotlrn_ta_rel">
		   <li>
	          <%= [acs_community_member_link -user_id $users(user_id) -label "$users(first_names) $users(last_name)"] %>
 	  	   <if @email_p@ eq 1>
	            (<%= [email_image::get_user_email -user_id $users(user_id)] %>)
		   </if>
                   <else>
	            (<a href="mailto:@users.email@">@users.email@</a>)
		   </else>
	           </li>
		      </if>
		   </multiple>
		  </ul>
		</if>
	     </td></tr>
	     <tr><td valign="top">
	      <if @n_cas@ gt 0>
	      <ul>	
	         @course_assistant_role_pretty_plural@:
	         <multiple name="users">
	          <if @users.rel_type@ eq "dotlrn_ca_rel">
	          <li>
	          <%= [acs_community_member_link -user_id $users(user_id) -label "$users(first_names) $users(last_name)"] %>
		  <if @email_p@ eq 1>
	            (<%= [email_image::get_user_email -user_id $users(user_id)] %>) 
		   </if>
                   <else>
	            (<a href="mailto:@users.email@">@users.email@</a>)
		   </else>
	          </li>
        	</if>
	      </multiple>
	    </ul>
	  </if>
         </td></tr>
    </table>
    </td>
</tr>
</table>
<br>



  

