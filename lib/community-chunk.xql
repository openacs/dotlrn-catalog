<?xml version="1.0"?>
<queryset>

    <fullquery name="get_community_info">
        <querytext>
	     select pretty_name, description, url from dotlrn_clubs_full
	     where community_id = :community_id
        </querytext>
    </fullquery>

</queryset>