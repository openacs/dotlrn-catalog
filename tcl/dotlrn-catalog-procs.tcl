ad_library {

    Tcl API for dotlrn_catalog store and manipulation

    @author Miguel Marin (miguelmarin@viaro.net) 
    @Viaro Networks (href=www.viaro.net>www.viaro.net)    
}

namespace eval dotlrn_catalog {}

ad_proc -private dotlrn_catalog::get_folder_id { } {
    Returns the folder_id of the folder with the name "DotLRN Catalog"
} {
    return [db_string check_folder_name { } ]
}

ad_proc -private dotlrn_catalog::get_item_id { 
    -revision_id:required
 } {
    Returns the item_id in the CR with the name @name@ under folder dotlrn_catalog
    @revision_id@  The revision_id to get the item id in the CR
} {
    return [db_string get_item_from_revision { } ]
}

ad_proc -public dotlrn_catalog::get_creation_user { 
    -object_id:required
} {
    Returns the creation_user of the object_id, returns -1 otherwise
    @object_id@    
} {
    return [db_string get_creation_user { } -default -1]
}

ad_proc -private dotlrn_catalog::set_live {
    -revision_id:required
} {
    Sets the live_revision to @revision_id@.
    @revision_id@ The revision to set as live
} {
    db_transaction {
	db_dml set_live_revision { }
    }
}


ad_proc -private dotlrn_catalog::check_name {
    -name:required
} {
    Checks if @name@ already exists in cr_item table
    @name@        The name of the course_key
} {
    if { [string equal [db_string check_item_name { } -default -1] "-1"] } {
	return 1
    } else {
	return 0
    }
}


ad_proc -private dotlrn_catalog::add_relation {
    -course_id:required
    -object_id:required
    -type:required
} {
    Add a new relation between course_id from dotlrn_catalog and object_id where relation type is type
    @course_id The id of the course in dotlrn_catalog
    @class_id  The class_instance_id of the class in dotlrn
    @type@     The type of the relation
} {
    db_exec_plsql add_relation { }
}

ad_proc -private dotlrn_catalog::has_relation_rel_id {
    -course_id:required
} {
    Returns  the class_id of dotlrn_class_instance related to course_id, returns 0 otherwise.
    @course_id The id of the course in dotlrn_catalog
} {
    return [db_string has_relation_rel_id { } -default 0]
}

ad_proc -private dotlrn_catalog::has_relation {
    -course_id:required
} {
    Returns 1 if there is a class_id of dotlrn_class_instance related to course_id, returns 0 otherwise.
    @course_id The id of the course in dotlrn_catalog
} {
    if { [db_string has_relation { } -default 0] == 0 } {
	return 0
    } else {
	return 1
    }
}

ad_proc -private dotlrn_catalog::relation_between {
    -object_one:required
    -object_two:required
} {
    Returns 1 if object_one is related to object_two, returns 0 otherwise.
    @object_one
    @object_two
} {
    if { [db_string relation_between { } -default 0] == 0 } {
	return 0
    } else {
	return 1
    }
}


ad_proc -private dotlrn_catalog::com_has_relation {
    -community_id:required
} {
    Returns 1 if there is a community of dotlrn related to course_id, returns 0 otherwise.
    @community_id The id of the community in dotlrn
} {
    if { [db_string com_has_relation { } -default 0] == 0 } {
	return 0
    } else {
	return 1
    }
}


ad_proc -private dotlrn_catalog::check_live_latest {
    -revision_id:required
} {
    Checks if @revision_id@ is the live revision or the latest revision in cr_items
    @revision_id@
} {
    set live [db_string check_live { } -default 0]
    set latest [db_string check_latest { } -default 0] 
    if { [string equal $live "0"] && [string equal $latest "0"] } {
	return 1
    } else {
	return 0
    }
}

ad_proc -private dotlrn_catalog::delete_row {
    -course_id:required
} {
    Deletes the row of dotlrn_catalog table and cr_revisions table where revision_id  = @course_id@
    @course_id The id of the course in dotlrn_catalog
} {
    if { [dotlrn_catalog::check_live_latest -revision_id $course_id] } {
	db_transaction {
	    db_dml delete_row { }
	    db_dml delete_rev { }
	}
	dotlrn_catalog::delete_relation -course_id $course_id
    }
}

ad_proc -private dotlrn_catalog::delete_relation {
    -rel_id:required
} {
    Deletes the relation of dotlrn_catalog and dotrln class or community
    @rel_id The id of the realtion
} {
    db_exec_plsql remove_relation { }
}

ad_proc -private dotlrn_catalog::grant_permissions {
    -party_id:required
    -object_id:required
    -creation_user:required
} {
    Gives admin permission to @party_id@ over @object_id@ and over all assessment_id created
    by @creation_user@
    @party_id@       The user_id to give permissions
    @object_id@      The course_id that the @party_id@ will have permissions on
    @creation_user@  The user_id of the user that creates the course_id
} {
    permission::grant -party_id $party_id -object_id $object_id  -privilege "admin"

    db_foreach assessment { } {
    	if {[permission::permission_p -party_id $creation_user -object_id $assessment_id -privilege "admin"] == 1} {
	    permission::grant -party_id $party_id -object_id $assessment_id  -privilege "admin"
	}
    } 
}

ad_proc -private dotlrn_catalog::revoke_permissions {
    -party_id:required
    -object_id:required
    -creation_user:required
} {
    Revokes  admin permission to @party_id@ over @object_id@ and over all assessment_id created
    by @creation_user@
    @party_id@       The user_id to revoke permissions
    @object_id@      The course_id over wich @party_id@ has permissions on
    @creation_user@  The user_id of the user that creates the course_id
} {
    permission::revoke -party_id $party_id -object_id $object_id  -privilege "admin"
    
    db_foreach assessment { } {
	if { [permission::permission_p -party_id $creation_user -object_id $assessment_id -privilege admin] == 1 } {
	    permission::revoke -party_id $party_id -object_id $assessment_id  -privilege "admin"
	}
    }
}

ad_proc -private dotlrn_catalog::check_rev_assoc {
    -item_id:required
} {
    Returns a list with number of revisions, number of associations to item_id
    @item_id@ The item_id to check
} {
    set rev_num [db_string revision_count { } -default 0]
    set assoc_num [db_string association_count { } -default 0]
    set return_list [list]
    lappend return_list $rev_num
    lappend return_list $assoc_num
    return $return_list
}

ad_proc -private dotlrn_catalog::course_delete {
    -item_id:required
} {
    Deletes item_id and all the associations to that item_id (revisions, relations)
    @item_id@ The item_id to delete
} {
    db_foreach relation { } {
	dotlrn_catalog::delete_relation -rel_id $rel_id
    } 
    content::item::delete -item_id $item_id
}

ad_proc -private dotlrn_catalog::get_categories_from_tree {
    -tree_id:required
} {
    Returns a list of all objects associated to one category under tree_id
    @tree_id@ The tree_id that holds the objects
} {
    set return_list ""
    db_foreach get_categories { } {
	lappend return_list "[list "$category_id" "$object_id"]"
    }
    return $return_list
}

ad_proc -private dotlrn_catalog::get_categories_widget {
} {
    Returns a list of all objects associated to one category under the dotlrn catalog tree_id
    @tree_id@ The tree_id that holds the objects
} {
    set return_list ""
    set name ""
    set cc_package_id [apm_package_id_from_key "dotlrn-catalog"]
    
    # The tree id from categories
    set tree_list [category_tree::get_mapped_trees $cc_package_id]
    if { [string equal [lindex [lindex $tree_list 0] 1] "dotlrn-course-catalog"] } {
	set tree_id [lindex [lindex $tree_list 0] 0]
    } else {
	set tree_id ""
    }
    
    
    set categories [category_tree::get_tree $tree_id]
    
    foreach cat $categories {
	set name ""
	set j [lindex $cat 3]
	for { set i 0} { $i < $j } {incr i} {
	    append name "."
	}
	append name " [lindex $cat 1]"
	lappend return_list [list $name [lindex $cat 0]]
    }
    
    return $return_list
}

ad_proc -public dotlrn_catalog::get_course_data {
    {-course_id:required}
} {
    Returns the course information (name,key and description) in the array course_data
    
} {
    upvar course_data course_data
    return [db_0or1row get_data {} -column_array course_data]
}