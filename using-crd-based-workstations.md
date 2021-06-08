# Using CRD-based workstations

Here are some example template snippets used to spin up Google Cloud resources
to run workstations that can be accessed via Chrome Remote Desktop.

Please note that these are provided only as examples to help guide
infrastructure planning and are not intended for use in production. They are
deliberately simplified for clarity and lack significant details required for
production-worthy infrastructure implementation.


![placeholder](images/vdi-on-cloud.png)

## Costs

If you run the example commands below, you will use billable components of
Google Cloud Platform, including:

- Compute Engine

You can use the
[Pricing Calculator](https://cloud.google.com/products/calculator)
to generate a cost estimate based on your projected usage.

Check out the [Google Cloud Free
Program](https://cloud.google.com/free/docs/gcp-free-tier) for potential
credits for tutorial resources.

## Before you begin

Start by opening
[https://console.cloud.google.com/](https://console.cloud.google.com/)
in a browser.

Create a new GCP Project using the
[Cloud Resource Manager](https://console.cloud.google.com/cloud-resource-manager).
The project you create is just for this example, so you'll delete it below
when you're done.

You will need to
[enable billing](https://support.google.com/cloud/answer/6293499#enable-billing)
for this project.

You will also need to enable the Compute Engine (GCE) service for this account

[Enable Example Services](https://console.cloud.google.com/flows/enableapi?apiid=compute.googleapis.com,cloudresourcemanager.googleapis.com)
    
Next, make sure the project you just created is selected in the top of the
Cloud Console.

Then open a Cloud Shell associated with the project you just created

[Launch Cloud Shell](https://console.cloud.google.com/?cloudshell=true)

It's important that the current Cloud Shell project is the one you just
created.  Verify that

```bash
echo $GOOGLE_CLOUD_PROJECT
```

shows that new project.

All example Terraform commands below run from this Cloud Shell.


## Example source

Get the source

```bash
git clone https://github.com/mmm/crd-workstations
cd crd-workstations
```

All example commands below are relative to this top-level directory of the
examples repo.

## Tools

We use [Terraform](terraform.io) for these examples and the latest version is
already installed in your GCP Cloudshell.


## Create a CRD-based workstation

Create a workstation instance

```bash
cd terraform/workstations
terraform init
terraform plan
terraform apply
```

This creates an example instance that's ready for chrome remote desktop
access to be configured below.


## Set up Chrome Remote Desktop

Open a browser and sign in and authorize

[Chrome Remote Desktop Configuration](https://remotedesktop.google.com/headless)

Copy the activation command for "Linux" that we'll past into the workstation below.


## SSH into your workstation to activate CRD

Log into your workstation using SecureShell (SSH)

```bash
gcloud compute ssh <workstation-name> --zone <zone>
```

for example

```bash
gcloud compute ssh cinnamon-workstation-0 --zone us-central1-f
```

At the workstation prompt, paste the CRD activation command
we copied above.

```bash
user_example_com@cinnamon-workstation-0:~$ DISPL# and the rest of the long command here
```

This usually throws up some warnings but completes just fine.

## Open the workstation's desktop using CRD

Back to your browser, click the "Remote Access" tab and you should see
the new workstation.

Happy computing on your new desktop!


## Cleaning up

To avoid incurring charges to your Google Cloud Platform account for the
resources used in this tutorial:

### Delete the project using the GCP Cloud Console

The easiest way to clean up all of the resources used in this tutorial is
to delete the project that you initially created for the tutorial.

Caution: Deleting a project has the following effects:
- Everything in the project is deleted. If you used an existing project for
  this tutorial, when you delete it, you also delete any other work you've done
  in the project.
- Custom project IDs are lost. When you created this project, you might have
  created a custom project ID that you want to use in the future. To preserve
  the URLs that use the project ID, such as an appspot.com URL, delete selected
  resources inside the project instead of deleting the whole project.

1. In the GCP Console, go to the Projects page.

    GO TO THE PROJECTS PAGE

2. In the project list, select the project you want to delete and click Delete
   delete.
3. In the dialog, type the project ID, and then click Shut down to delete the
   project.

### Deleting resources using Terraform

Alternatively, if you added the tutorial resources to an _existing_ project, you
can still clean up those resources using Terraform.

From the `workstations` sub-directory, run

```bash
terraform destroy
```

## What's next

There are so many exciting directions to take to learn more about what you've
done here!

- Infrastructure.  Learn more about
  [Cloud](https://cloud.google.com/),
  High Performance Computing (HPC) on GCP
  [reference architectures](https://cloud.google.com/solutions/hpc/) and 
  [posts](https://cloud.google.com/blog/topics/hpc).

