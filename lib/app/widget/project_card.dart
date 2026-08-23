import 'package:flutter/material.dart';

import '../../data/models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final int taskCount;
  final VoidCallback onTap;
  

  const ProjectCard({
    super.key,
    required this.project,
    required this.taskCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(12),

        onTap: onTap,

        child: Padding(
          padding:
              const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      project.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  _buildStatusChip(),
                ],
              ),

              const SizedBox(height: 8),

              if (project.description != null &&
                  project.description!
                      .isNotEmpty)
                Text(
                  project.description!,
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                ),

              const SizedBox(height: 16),

              Row(
                children: [
                  const Icon(
                    Icons.task_alt,
                    size: 18,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    '$taskCount Tasks',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Text(
        project.status.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}