An app has product features that help guide users through a marketing funnel. Each feature has "steps" (i.e., actions users can take) as a guide to complete the funnel. What is the average percentage of completion for each feature?


WITH max_step AS
  (SELECT feature_id,
          user_id,
          max(step_reached) AS max_step_reached
   FROM facebook_product_features_realizations
   GROUP BY feature_id,
            user_id),
     calc_per_feature AS
  (SELECT feats.feature_id,
          n_steps,
          max_step_reached,
          COALESCE(max_step_reached, 0) / n_steps::float AS share_of_completion
   FROM facebook_product_features feats
   LEFT OUTER JOIN max_step ON feats.feature_id = max_step.feature_id)
SELECT feature_id,
       avg(share_of_completion) * 100 AS avg_share_of_completion
FROM calc_per_feature
GROUP BY feature_id
