import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;
   

  const TaskCard({
    super.key,
    required this.task,
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
          child: Row(
            children: [
              _buildPriorityIndicator(),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    if (task.description != null &&
                        task.description!
                            .isNotEmpty)
                      Text(
                        task.description!,
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                      ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        _buildChip(
                          task.status,
                          Icons.check_circle_outline,
                        ),

                        const SizedBox(width: 8),

                        _buildChip(
                          task.priority,
                          Icons.flag_outlined,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityIndicator() {
    Color color;

    switch (task.priority) {
      case 'high':
        color = Colors.red;
        break;

      case 'medium':
        color = Colors.orange;
        break;

      default:
        color = Colors.green;
    }

    return Container(
      width: 6,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildChip(
    String text,
    IconData icon,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
          ),

          const SizedBox(width: 4),

          Text(
            text.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}