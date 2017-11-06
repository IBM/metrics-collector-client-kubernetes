import json
import yaml

#global variables
language = ''

class MyDumper(yaml.Dumper):
	# Reference from Pyyaml ticket 64
    def increase_indent(self, flow=False, indentless=False):
        return super(MyDumper, self).increase_indent(flow, False)

def getJson():
	try:
		f = open("repository.yaml", "r")
		response = f.read()
		original = yaml.load(response)
		data = json.loads(json.dumps(original))
		f.close()
		return data
	except:
		print("Missing repository.yaml")

def formatData(data):
	newData = {}
	try:
		newData['repository_id'] = data['id'] if data.get("id") else ''
		newData['target_runtimes'] = data['runtimes'] if data.get("runtimes") else ''
		newData['target_services'] = data['services'] if data.get("services") else ''
		newData['event_id'] = data['event_id'] if data.get("event_id") else ''
		newData['event_organizer'] = data['event_organizer'] if data.get("event_organizer") else ''
		global language
		language = data['language'] if data.get("language") else ''
		return newData
	except:
		print("Wrong contents in repository.yaml")

def getSampleJob():
	try:
		f = open("sample.yaml","r")
		response = f.read()
		resYaml = yaml.load(response)
		f.close()
		return resYaml
	except:
		print("Missing sample.yaml")

def createJob(sample,data):
	try:
		sample['spec']['template']['spec']['containers'][0]['env'][0]['value'] = json.dumps(data)
		sample['spec']['template']['spec']['containers'][0]['env'][1]['value'] = json.dumps(language).replace('"','')
		if data.get("repository_id"):
			metric_name = '-'.join([json.dumps(data['repository_id']).replace('"', '').lower(),'metrics'])
			sample['spec']['template']['spec']['containers'][0]['name'] = metric_name
			sample['spec']['template']['metadata']['name'] = metric_name
			sample['metadata']['name'] = metric_name
		f = open("metricjob.yaml", "w")
		f.write(''.join(['---\n',yaml.dump(sample, Dumper=MyDumper, width=50)]))
		f.close()
	except:
		print("Wrong contents in sample.yaml")

if __name__ == "__main__":
	data = getJson()
	data = formatData(data)
	sample = getSampleJob()
	createJob(sample,data)