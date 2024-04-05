//
//  BruteForceAlg.cpp
//  FairDivision
//
//  Created by Anushka Sankaran on 3/22/24.
//

#include "BruteForceAlg.hpp"

std::vector<std::vector<int>> generate_owner_vectors(int num_agents, int num_items) {
    int max_alloc_num = std::pow(num_agents, num_items);
    std::vector<std::vector<int>> owner_vectors;

    for (int alloc_num = 0; alloc_num < max_alloc_num; alloc_num++) {
        std::vector<int> owner_vector;
        for (int j = 0; j < num_items; j++) {
            owner_vector.push_back(alloc_num % num_agents);
            alloc_num /= num_agents;
        }
        owner_vectors.push_back(owner_vector);
    }

    return owner_vectors;
}

// Function to generate all allocations
std::vector<std::vector<std::vector<int>>> generate_all_allocations(int num_agents, int num_items) {
    auto owner_vectors = generate_owner_vectors(num_agents, num_items);
    std::vector<std::vector<std::vector<int>>> allocations;

    for (const auto& owner_vector : owner_vectors) {
        std::vector<std::vector<int>> alloc(num_agents, std::vector<int>());
        for (int j = 0; j < num_items; j++) {
            alloc[owner_vector[j]].push_back(j);
        }
        allocations.push_back(alloc);
    }

    return allocations;
}

// Function to get maximum Nash welfare
std::pair<std::vector<std::vector<int>>, double> get_max_nash_welfare(int num_agents, int num_items, const std::vector<std::vector<int>>& valuation_matrix) {
    double opt_nash_welfare = -1;
    std::vector<std::vector<int>> opt_alloc;

    auto allocations = generate_all_allocations(num_agents, num_items);

    for (const auto& alloc : allocations) {
        std::vector<double> values(num_agents, 0.0);
        for (int i = 0; i < num_agents; i++) {
            for (int j : alloc[i]) {
                values[i] += valuation_matrix[i][j];
            }
        }

        double nash_welfare = 1.0;
        for (double value : values) {
            nash_welfare *= value;
        }

        if (nash_welfare > opt_nash_welfare) {
            opt_nash_welfare = nash_welfare;
            opt_alloc = alloc;
        }
    }

    return std::make_pair(opt_alloc, opt_nash_welfare);
}
