#!/bin/sh

# script make it executable - $chmod u+x freebsd_single_handbook_article_for_ruby.sh

# variable definition

SITE=$1

SECTION_TYPE=$2

SUBSECTIONS=$3

PACKAGE_TYPE=$4

# end variable definition

# function definition

test_bsd_test(){
    echo "display all parameters"
    echo ${SITE} ${SECTION_TYPE} ${SUBSECTIONS} ${PACKAGE_TYPE}
    return
}

test_bsd_documentation(){
    echo "creation ${SUBSECTIONS} of ${SECTION_TYPE}"; \
    echo ${SITE}/${SECTION_TYPE}/${SUBSECTIONS}/${PACKAGE_TYPE};
    return
}

create_bsd_documentation(){
    echo "creation ${SUBSECTIONS} of ${SECTION_TYPE}"; \
    curl ${SITE}/${SECTION_TYPE}/${SUBSECTIONS}/${PACKAGE_TYPE} > ./${SECTION_TYPE}/${SUBSECTIONS}/${PACKAGE_TYPE}; \
    cd ${SECTION_TYPE}/${SUBSECTIONS} && tar xvjf ${PACKAGE_TYPE}; \
    cd ../.. ; \
    return
}

display_banner(){
    echo " "
    echo "download freebsd single ${SECTION_TYPE}"
    echo "   "
    return
}

# end function definition

# main shell

display_banner

#test_bsd_test

#test_bsd_documentation

create_bsd_documentation

exit