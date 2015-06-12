import csv

from sklearn.cluster import KMeans
import numpy as np


def read_csv_contents(filename):
    """Reads contents of a csv file and returns the row as a tuple
        Parameters
        -----------
        filename - string Name of the csv file
    """
    file_contents = []
    with open(filename, 'r') as fp:
        rows = csv.reader(fp)
        for row in rows:
            #  tuples are immutable
            file_contents.append(tuple(row))
    return file_contents


def categorise_dataset(contents):
    iris_setosa = []
    iris_versicolor = []
    iris_virginica = []
    for each_tuple in contents:
        if each_tuple[4] == 'Iris-virginica':
            iris_virginica.append(each_tuple[:4])
        elif each_tuple[4] == 'Iris-versicolor':
            iris_versicolor.append(each_tuple[:4])
        elif each_tuple[4] == 'Iris-setosa':
            iris_setosa.append(each_tuple[:4])

    kwargs = {
        'n_init': 5,
        # depends on number of cores in your machine.
        'n_jobs': 3,
        'n_clusters': 3,
    }
    kmeans = KMeans()
    kmeans.set_params(**kwargs)
    # apply kmeans
    iris_setosa_centroids_indices = kmeans.fit_predict(np.array(iris_setosa))
    iris_setosa_centroids = kmeans.cluster_centers_

    iris_versicolor_centroids_indices = kmeans.fit_predict(np.array(iris_versicolor))
    iris_versicolor_centroids = kmeans.cluster_centers_

    iris_virginica_centroids_indices = kmeans.fit_predict(np.array(iris_virginica))
    iris_virginica_centroids = kmeans.cluster_centers_
    return (iris_setosa_centroids,
            iris_versicolor_centroids,
            iris_virginica_centroids)


if __name__ == '__main__':
    contents = read_csv_contents('iris.csv')
    centroids = categorise_dataset(contents)
