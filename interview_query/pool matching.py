
'''
You’re given a list of people to match together in a pool of candidates.

We want to match up people based on two ways:

A hard filter on scheduled availability

A closest match based on similar interests
'''


def pool_matching(people):
    """
     1. Convert timestring to timestamp 
     2. Covert timestamp to timestring
     1-2. Compare timestamps
     3. Check for soft match
     4. Find highest number of matches and greedily proceed with that
     5. Optimise with graph based approach
    """

    def match_score(person1, person2):
        if len(set(person1['availability']).intersection(person2['availability'])):
            return len(set(person1['interests']).intersection(person2['interests']))
        return -1

    def create_match(person1, person2):
        interests1 = person1['interests'];
        interests2 = person2['interests'];

        return {
            'match': (person1['name'], person2['name']),
            'scheduled_date': list(set(person1['availability']).intersection(person2['availability'])),
            'overlapping_interests': list(set(interests1).intersection(interests2))
        }

    matches = []
    no_matches = []
    for i in range(0, len(people)):
        if people[i] is not None:
            continue

        index = None
        match_score_i = -1
        for j in range(i+1, len(people)):
            match_score_ij = match_score(people[i], people[j])
            if match_score_i < match_score_ij:
                index = j
                match_score_i = match_score_ij

        if index is not None:
            matches.append(create_match(people[i], people[index]))
            people[i+1], people[index] = None, people[i+1]
        else:
            no_matches.append(people[i])

    return [matches, no_matches]
