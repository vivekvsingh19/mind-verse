import 'package:flutter/material.dart';

class CounselorPanel extends StatefulWidget {
  const CounselorPanel({super.key});

  @override
  State<CounselorPanel> createState() => _CounselorPanelState();
}

class _CounselorPanelState extends State<CounselorPanel> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Counselor Dashboard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Manage your patients and track their progress',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('New Session'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Stats Row
          _buildCounselorStats(),
          const SizedBox(height: 24),
          
          // Main Content
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 1200;
              return isDesktop 
                  ? _buildDesktopLayout()
                  : _buildMobileLayout();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCounselorStats() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Active Patients', '24', Icons.people, Colors.blue)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatCard('Sessions Today', '6', Icons.event, Colors.green)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatCard('Urgent Cases', '2', Icons.priority_high, Colors.red)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatCard('Avg. Progress', '85%', Icons.trending_up, Colors.purple)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.trending_up, color: color, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column - Patient List & Schedule
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildTodaySchedule(),
              const SizedBox(height: 24),
              _buildPatientList(),
            ],
          ),
        ),
        const SizedBox(width: 24),
        
        // Right Column - Patient Details & Actions
        Expanded(
          flex: 1,
          child: Column(
            children: [
              _buildUrgentAlerts(),
              const SizedBox(height: 24),
              _buildQuickActions(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildUrgentAlerts(),
        const SizedBox(height: 24),
        _buildTodaySchedule(),
        const SizedBox(height: 24),
        _buildQuickActions(),
        const SizedBox(height: 24),
        _buildPatientList(),
      ],
    );
  }

  Widget _buildTodaySchedule() {
    final appointments = [
      {
        'patient': 'Patient #001',
        'time': '9:00 AM',
        'type': 'Individual Therapy',
        'status': 'confirmed',
        'urgency': 'normal',
      },
      {
        'patient': 'Patient #015',
        'time': '10:30 AM',
        'type': 'Follow-up Session',
        'status': 'confirmed',
        'urgency': 'high',
      },
      {
        'patient': 'Patient #023',
        'time': '2:00 PM',
        'type': 'Initial Assessment',
        'status': 'pending',
        'urgency': 'normal',
      },
      {
        'patient': 'Patient #008',
        'time': '3:30 PM',
        'type': 'Group Therapy',
        'status': 'confirmed',
        'urgency': 'normal',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Today\'s Schedule',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View Calendar'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          ...appointments.map((appointment) => _buildAppointmentCard(
            appointment['patient'] as String,
            appointment['time'] as String,
            appointment['type'] as String,
            appointment['status'] as String,
            appointment['urgency'] as String,
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(String patient, String time, String type, String status, String urgency) {
    Color statusColor = status == 'confirmed' ? Colors.green : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: urgency == 'high' ? Colors.red.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.person,
              color: statusColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      patient,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (urgency == 'high')
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'URGENT',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  type,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('View Details')),
              const PopupMenuItem(child: Text('Reschedule')),
              const PopupMenuItem(child: Text('Cancel')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatientList() {
    final patients = [
      {
        'id': '001',
        'initials': 'JS',
        'lastSeen': '2 days ago',
        'status': 'stable',
        'riskLevel': 'low',
        'nextSession': 'Tomorrow',
      },
      {
        'id': '015',
        'initials': 'AM',
        'lastSeen': '1 week ago',
        'status': 'improving',
        'riskLevel': 'medium',
        'nextSession': 'Today',
      },
      {
        'id': '023',
        'initials': 'RK',
        'lastSeen': 'New patient',
        'status': 'assessment',
        'riskLevel': 'unknown',
        'nextSession': 'Today',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Patient Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          ...patients.map((patient) => _buildPatientCard(
            patient['id'] as String,
            patient['initials'] as String,
            patient['lastSeen'] as String,
            patient['status'] as String,
            patient['riskLevel'] as String,
            patient['nextSession'] as String,
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildPatientCard(String id, String initials, String lastSeen, String status, String riskLevel, String nextSession) {
    Color riskColor = riskLevel == 'high' ? Colors.red : 
                     riskLevel == 'medium' ? Colors.orange : 
                     riskLevel == 'low' ? Colors.green : Colors.grey;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: riskColor.withOpacity(0.1),
            child: Text(
              initials,
              style: TextStyle(
                color: riskColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Patient #$id',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: riskColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        riskLevel.toUpperCase(),
                        style: TextStyle(
                          color: riskColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Last seen: $lastSeen',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Next: $nextSession',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildUrgentAlerts() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: Colors.red[600]),
              const SizedBox(width: 8),
              const Text(
                'Urgent Alerts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          _buildAlertItem(
            'Patient #015 missed scheduled check-in',
            '2 hours ago',
            Colors.red,
            Icons.person_off,
          ),
          _buildAlertItem(
            'High stress indicators detected for Patient #007',
            '4 hours ago',
            Colors.orange,
            Icons.trending_up,
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(String title, String time, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'title': 'Emergency Protocol', 'icon': Icons.emergency, 'color': Colors.red},
      {'title': 'Schedule Session', 'icon': Icons.calendar_month, 'color': Colors.blue},
      {'title': 'Send Message', 'icon': Icons.message, 'color': Colors.green},
      {'title': 'Generate Report', 'icon': Icons.assessment, 'color': Colors.purple},
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              return InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: (action['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (action['color'] as Color).withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        action['icon'] as IconData,
                        color: action['color'] as Color,
                        size: 28,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        action['title'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: action['color'] as Color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
