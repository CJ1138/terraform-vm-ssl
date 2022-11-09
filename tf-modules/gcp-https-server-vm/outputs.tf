output "instance_group_id" {
  description = "ID for the created instance group."
  value       = google_compute_instance_group.webserver_group.id
}