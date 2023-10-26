
'''
Say we have a list of existing_ids that we have already scraped. Let’s say we also have two lists, one of names and another of urls that correspond to names with the id of the names in the url.

Write a function new_resumes to return the names and ids for ids that we haven’t scraped yet.
'''

def new_resumes(existing_ids, names, urls):
    

    output = []
    for u,name in zip(urls, names):

        newid = u.split('/')[-1]

        newid = int(newid)

        if newid not in existing_ids:

            output.append([name, newid])
    
    return  output
