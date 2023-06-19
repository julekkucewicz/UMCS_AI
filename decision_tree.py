import numpy as np
from collections import Counter

class Node:
    def __init__(self, feature=None, threshold=None, left=None, right=None, *, value=None):
        self.feature = feature
        self.threshold = threshold
        self.left = left
        self.right = right
        self.value = value
    def is_leaf_node(self):
        return self.value is not None
class DecisionTree:
    def __init__(self, min_samples_split=2, max_depth=100, n_features=None):
        self.min_samples_split=min_samples_split
        self.max_depth=max_depth
        self.n_features=n_features
        self.root=None
    def fit(self, X, y):
        if not self.n_features or  self.n_features > X.shape[1] :
            self.n_features = X.shape[1]
        self.root=self._grow_tree(X,y)
    def _grow_tree(self, X, y, depth=0):
        features_num = X.shape[1]
        samples_num = X.shape[0]
        
        if self.min_samples_split > samples_num or len(np.unique(y)) == 1 or self.max_depth <= depth:
            return Node(value=Counter(y).most_common(1)[0][0])

        feat_ids = np.random.choice(features_num, self.n_features, replace=False)
        best_split = self._best_split(X, y, feat_ids)
        feat_best = best_split[0]
        threshold_best = best_split[1]

        split = self._split(X[:, feat_best], threshold_best)

        left = self._grow_tree(X[split[0], :], y[split[0]], depth + 1)
        right = self._grow_tree(X[split[1], :], y[split[1]], depth + 1)

        return Node(feat_best, threshold_best, left, right)
    def _best_split(self, X, y, feat_ids):
        s_id = None
        s_thresh = None
        ig = -1

        for i in feat_ids:
            threshs = np.unique(X[:, i])
            for j in range(1, len(threshs)):
                mid = 0.5 * (threshs[j-1] + threshs[j])
                curr_ig = self._information_gain(y, X[:, i], mid)

                if ig < curr_ig:
                    s_id = i
                    s_thresh = mid
                    ig = curr_ig

        return s_id, s_thresh
    def _information_gain(self, y, X_column, threshold):
        parent = self._entropy(y)
        split = self._split(X_column, threshold)
        
        if len(split[0]) != 0 and len(split[1]) != 0:
            left = self._entropy(y[split[0]])
            right = self._entropy(y[split[1]])
            child = (left * len(split[0]) + right * len(split[1])) / len(y)
            return parent - child
        else:
            return 0
    def _split(self, X_column, split_thresh):
        split = np.where(X_column <= split_thresh)[0], np.where(X_column > split_thresh)[0]
        return split
    def _entropy(self, y):
        hist = np.bincount(y)
        ps = hist / len(y)
        return -np.sum([p * np.log(p) for p in ps if p>0])
    def _traverse_tree(self, x, node):
        if node.is_leaf_node():
            return node.value
        else:
            if x[node.feature] > node.threshold:
                return self._traverse_tree(x, node.right)
            else:
                return self._traverse_tree(x, node.left)
    def predict(self, X):
        return np.array([self._traverse_tree(x, self.root) for x in X])
    
