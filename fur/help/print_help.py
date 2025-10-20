import sys


def print_help():
    print("""
    Available functions: 
    open-remote
    commit
    commits
    issues
    issue (aliases: task, bug, ticket, work-item)
    pull-requests (aliases: prs)
    pull-request (aliases: pr)
    create-pull-request (aliases: cpr)
    
    Use `fur [function] -h` to get help on the function.
    Use `fur test [function] [args]` to print the URL that will be opened by the function.
    """, file=sys.stderr)
