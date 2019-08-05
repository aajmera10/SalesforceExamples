declare module "@salesforce/apex/gddr.supra" {
  export default function supra(param: {Id: any, status: any, reason: any}): Promise<any>;
}
declare module "@salesforce/apex/gddr.getStatus" {
  export default function getStatus(param: {Id: any}): Promise<any>;
}
